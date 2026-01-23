<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Project Grades - {{ $project->title }}</title>
    <style>
        body {
            font-family: 'DejaVu Sans', sans-serif;
            font-size: 12px;
            line-height: 1.6;
            color: #333;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #333;
            padding-bottom: 20px;
        }
        .header h1 {
            font-size: 24px;
            margin: 0;
            color: #1a56db;
        }
        .header h2 {
            font-size: 18px;
            margin: 10px 0 0 0;
            font-weight: normal;
        }
        .info-section {
            margin-bottom: 20px;
        }
        .info-row {
            margin-bottom: 8px;
        }
        .label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th {
            background-color: #f3f4f6;
            border: 1px solid #d1d5db;
            padding: 10px;
            text-align: left;
            font-weight: bold;
        }
        td {
            border: 1px solid #d1d5db;
            padding: 8px;
        }
        .defense-header {
            background-color: #e5e7eb;
            font-weight: bold;
            font-size: 14px;
            padding: 12px;
            margin-top: 20px;
        }
        .total-section {
            margin-top: 30px;
            padding: 15px;
            background-color: #f9fafb;
            border: 2px solid #1a56db;
            text-align: center;
        }
        .total-grade {
            font-size: 24px;
            font-weight: bold;
            color: #1a56db;
        }
        .footer {
            margin-top: 40px;
            text-align: center;
            font-size: 10px;
            color: #6b7280;
            border-top: 1px solid #d1d5db;
            padding-top: 10px;
        }
        .students-list {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Project Grades Report</h1>
        <h2>{{ $project->title }}</h2>
    </div>

    <div class="info-section">
        <div class="info-row">
            <span class="label">Department:</span>
            <span>{{ $project->department->name ?? 'N/A' }}</span>
        </div>
        <div class="info-row">
            <span class="label">Specialization:</span>
            <span>{{ $project->specialization->name ?? 'N/A' }}</span>
        </div>
        <div class="info-row">
            <span class="label">Project Type:</span>
            <span>{{ $project->project_type }}</span>
        </div>
        <div class="info-row">
            <span class="label">Export Date:</span>
            <span>{{ $exportDate }}</span>
        </div>
    </div>

    <div class="students-list">
        <h3>Students:</h3>
        <ul>
            @foreach($project->students as $student)
                <li>{{ $student->name }} ({{ $student->email }})</li>
            @endforeach
        </ul>
    </div>

    <div class="students-list">
        <h3>Supervisors:</h3>
        <ul>
            @foreach($project->supervisors as $supervisor)
                <li>{{ $supervisor->name }}</li>
            @endforeach
        </ul>
    </div>

    @foreach($gradeData as $defense)
        <div class="defense-header">
            {{ ucfirst($defense['discussion_type']) }} Defense - 
            Grade: {{ $defense['total_grade'] ?? 'Not graded' }} / {{ $defense['max_grade'] }}
        </div>

        <table>
            <thead>
                <tr>
                    <th>Committee Member</th>
                    <th>Grade</th>
                    <th>Feedback</th>
                    <th>Graded At</th>
                </tr>
            </thead>
            <tbody>
                @foreach($defense['member_grades'] as $memberGrade)
                    <tr>
                        <td>{{ $memberGrade['member_name'] }}</td>
                        <td>{{ $memberGrade['grade'] ?? 'N/A' }}</td>
                        <td>{{ $memberGrade['feedback'] ?? 'No feedback' }}</td>
                        <td>{{ $memberGrade['graded_at'] ? date('M d, Y', strtotime($memberGrade['graded_at'])) : 'N/A' }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @endforeach

    <div class="total-section">
        <div>Total Project Grade</div>
        <div class="total-grade">{{ $totalGrade }} / {{ $maxTotalGrade }}</div>
        <div style="font-size: 14px; margin-top: 10px;">
            Percentage: {{ $maxTotalGrade > 0 ? round(($totalGrade / $maxTotalGrade) * 100, 2) : 0 }}%
        </div>
    </div>

    <div class="footer">
        <p>This document was generated on {{ $exportDate }}</p>
        <p>Thesis Management System</p>
    </div>
</body>
</html>
