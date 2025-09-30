# Dark Mode Contrast Fix Script
Write-Host "Fixing dark mode text contrast..." -ForegroundColor Green

# Fix existing incorrect dark mode classes
$fixes = @(
    @{ Old = 'text-gray-600 dark:text-gray-400 dark:text-gray-500'; New = 'text-gray-600 dark:text-gray-300' }
    @{ Old = 'text-gray-600 dark:text-gray-400'; New = 'text-gray-600 dark:text-gray-300' }
    @{ Old = 'text-gray-500 dark:text-gray-500'; New = 'text-gray-500 dark:text-gray-400' }
    @{ Old = 'text-gray-700 dark:text-gray-300'; New = 'text-gray-700 dark:text-gray-200' }
)

$files = Get-ChildItem -Path "src/pages/*.tsx" -Recurse
Write-Host "Processing $($files.Count) files..." -ForegroundColor Cyan

$updatedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    foreach ($fix in $fixes) {
        $content = $content -replace [regex]::Escape($fix.Old), $fix.New
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "  Updated: $($file.Name)" -ForegroundColor Yellow
        $updatedCount++
    }
}

Write-Host "`nComplete! Updated $updatedCount file(s)" -ForegroundColor Green
Write-Host "Text colors now have better contrast in dark mode" -ForegroundColor Cyan
