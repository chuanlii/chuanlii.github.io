param(
    [Parameter(Position = 0)]
    [string]$Command = "help",

    [Parameter(Position = 1)]
    [string]$Argument = ""
)

$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
$hugo = Join-Path $root "tools\hugo\hugo.exe"

function Require-Hugo {
    if (-not (Test-Path $hugo)) {
        throw "Hugo executable not found: $hugo"
    }
}

function Run-Hugo {
    param(
        [string[]]$HugoArgs
    )

    Require-Hugo
    & $hugo @HugoArgs
}

function Show-Help {
    @"
Usage:
  powershell -ExecutionPolicy Bypass -File .\blog.ps1 help
  powershell -ExecutionPolicy Bypass -File .\blog.ps1 new my-first-post
  powershell -ExecutionPolicy Bypass -File .\blog.ps1 serve
  powershell -ExecutionPolicy Bypass -File .\blog.ps1 build
  powershell -ExecutionPolicy Bypass -File .\blog.ps1 publish "更新文章"

Commands:
  help      Show this help text
  new       Create a new post in content/posts/
  serve     Start the local Hugo server with drafts enabled
  build     Build the site into public/
  publish   Git add, commit, and push to origin/main
"@ | Write-Output
}

switch ($Command.ToLowerInvariant()) {
    "help" {
        Show-Help
    }
    "new" {
        if ([string]::IsNullOrWhiteSpace($Argument)) {
            throw "Please provide a post name. Example: .\blog.ps1 new my-first-post"
        }
        Run-Hugo -HugoArgs @("new", "content/posts/$Argument.md")
    }
    "serve" {
        Run-Hugo -HugoArgs @("server", "-D")
    }
    "build" {
        Run-Hugo -HugoArgs @("--minify")
    }
    "publish" {
        $message = $Argument
        if ([string]::IsNullOrWhiteSpace($message)) {
            $message = "Update site content"
        }

        git -C $root add .
        git -C $root commit -m $message
        git -C $root push origin main
    }
    default {
        throw "Unknown command: $Command. Run .\blog.ps1 help"
    }
}
