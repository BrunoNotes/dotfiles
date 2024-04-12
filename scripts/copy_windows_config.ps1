$LocalNeovideFolder = "$env:USERPROFILE\AppData\Local\neovide"
$LocalNeovimFolder = "$env:USERPROFILE\AppData\Local\nvim"

$NeovideFolder = "$env:USERPROFILE\Documents\dotfiles\home\.config\neovide"
$NeovimFolder = "$env:USERPROFILE\Documents\dotfiles\home\.config\nvim"

#Write-Host "$env:USERPROFILE\Documentos"

"Test to see if folder [$LocalNeovideFolder]  exists"
if (Test-Path -Path $LocalNeovideFolder) {
    #"Path exists!"
    Remove-Item $LocalNeovideFolder
} else {
    "Path doesn't exist."
}

"Test to see if folder [$LocalNeovimFolder]  exists"
if (Test-Path -Path $LocalNeovimFolder) {
    #"Path exists!"
    Remove-Item $LocalNeovimFolder
} else {
    "Path doesn't exist."
}

Copy-Item -Path $NeovideFolder -Destination $LocalNeovideFolder -Recurse
Copy-Item -Path $NeovimFolder -Destination $LocalNeovimFolder -Recurse