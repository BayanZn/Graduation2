<?php

namespace App\Http\Controllers;

use App\Models\Upload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Spatie\Image\Enums\ImageDriver;
use Spatie\Image\Image;
use Spatie\MediaLibrary\MediaCollections\Models\Media;

class UploadsController extends Controller
{
    public function filepondUpload(Request $request)
    {
        $request->validate([
            'image' => 'required|image|mimes:png,jpeg,jpg',
        ]);

        if ($request->hasFile('image')) {
            $uploaded_file = $request->file('image');
            $filename = uniqid().now()->timestamp.'.'.$uploaded_file->getClientOriginalExtension();
            $folder = uniqid().'-'.now()->timestamp;

            $image = Image::useImageDriver(ImageDriver::Gd)->loadFile($uploaded_file->getRealPath());

            $image->optimize();

            $image->save(Storage::path('temp/'.$filename));

            Upload::create([
                'folder' => $folder,
                'filename' => $filename,
            ]);

            return $filename;
        }

        return false;
    }

    public function filepondRevert(Request $request, $filename)
    {
        $upload = Upload::where('filename', $filename)->first();

        Storage::delete('temp/'.$upload->filename);
        $upload->delete();

        return response(null);
    }

    public function filepondRemove(Request $request, $filename)
    {
        $file = Media::where('file_name', $filename)->first();

        $file->delete();

        return response(null);
    }
}
