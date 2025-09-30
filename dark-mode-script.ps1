# Dark Mode Update Script for Kashrus Management System

# Common replacements for dark mode
$replacements = @(
    # Cards and containers
    @{ Old = 'bg-white rounded-lg shadow'; New = 'bg-white dark:bg-gray-800 rounded-lg shadow dark:shadow-gray-900' }
    @{ Old = 'bg-white divide-y divide-gray-200'; New = 'bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700' }
    
    # Text colors  
    @{ Old = 'text-gray-900'; New = 'text-gray-900 dark:text-gray-100' }
    @{ Old = 'text-gray-800'; New = 'text-gray-800 dark:text-gray-200' }
    @{ Old = 'text-gray-700'; New = 'text-gray-700 dark:text-gray-300' }
    @{ Old = 'text-gray-600'; New = 'text-gray-600 dark:text-gray-400' }
    @{ Old = 'text-gray-500'; New = 'text-gray-500 dark:text-gray-500' }
    @{ Old = 'text-gray-400'; New = 'text-gray-400 dark:text-gray-500' }
    
    # Borders
    @{ Old = 'border-gray-300'; New = 'border-gray-300 dark:border-gray-600' }
    @{ Old = 'border-gray-200'; New = 'border-gray-200 dark:border-gray-700' }
    
    # Hover states
    @{ Old = 'hover:bg-gray-50'; New = 'hover:bg-gray-50 dark:hover:bg-gray-700' }
    @{ Old = 'hover:bg-gray-100'; New = 'hover:bg-gray-100 dark:hover:bg-gray-700' }
    @{ Old = 'hover:text-gray-900'; New = 'hover:text-gray-900 dark:hover:text-gray-100' }
    
    # Backgrounds
    @{ Old = 'bg-gray-50'; New = 'bg-gray-50 dark:bg-gray-800' }
    @{ Old = 'bg-gray-100'; New = 'bg-gray-100 dark:bg-gray-700' }
)

# Get all TypeScript files in pages directory
$files = Get-ChildItem -Path "src/pages/*.tsx" -Recurse

Write-Host "Processing $($files.Count) files..." -ForegroundColor Green

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    foreach ($replacement in $replacements) {
        $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated: $($file.Name)" -ForegroundColor Yellow
    }
}

Write-Host "`nDark mode classes added successfully!" -ForegroundColor Green
Write-Host "Note: Manual review recommended for complex cases." -ForegroundColor Cyan
