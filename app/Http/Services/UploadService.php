<?php

namespace App\Http\Services;

use App\Models\Upload;
use Illuminate\Support\Facades\Storage;

class UploadService
{
    public function uploadImage($model, $images, $collection = 'default'): void
    {
        $tempImages = Upload::whereIn('filename', $images)->get();

        if ($model->getMedia($collection)) {
            foreach ($model->getMedia($collection) as $media) {
                if (! in_array($media->file_name, $images)) {
                    $media->delete();
                }
            }
        }

        // add to media collection from temp storage
        if ($tempImages->count() > 0) {
            foreach ($tempImages as $temp) {
                $model->addMedia(Storage::path('temp/'.$temp->filename))
                    ->toMediaCollection($collection);

                Storage::delete('temp/'.$temp->filename);
                $temp->delete();
            }
        }
    }

    public function uploadFile($model, $files, $collection = 'default'): void
    {
        if ($model->getMedia($collection)) {
            foreach ($model->getMedia($collection) as $media) {
                if (! in_array($media->file_name, $files)) {
                    $media->delete();
                }
            }
        }

        // add to media collection from request
        if (request()->hasFile('files')) {
            foreach (request()->file('files') as $file) {
                // make filename unique
                $filename = uniqid().now()->timestamp.'.'.$file->getClientOriginalExtension();

                $model->addMedia($file)
                    ->usingFileName($filename)
                    ->toMediaCollection($collection);
            }
        }
    }
}
