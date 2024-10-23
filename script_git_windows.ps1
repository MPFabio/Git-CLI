# Installer GitHub CLI via winget
Write-Host "Installation de GitHub CLI..."
winget install --id GitHub.cli

# Authentification avec GitHub CLI
Write-Host "Authentification avec GitHub CLI..."
gh auth login

# Créer un dossier pour le nouveau repo
$nom_dossier = Read-Host "Entrez le nom du dossier à créer"
New-Item -Path . -Name $nom_dossier -ItemType "directory"
Set-Location $nom_dossier

# Créer un repo GitHub
Write-Host "Création d'un nouveau repo GitHub..."
gh repo create

# Modifier le README
$texte_readme = Read-Host "Entrez le texte à ajouter au README"
Add-Content -Path "README.md" -Value $texte_readme

# Ajouter les modifications au Staging Area
git add README.md

# Commit avec un message
$message_commit = Read-Host "Entrez un message pour le commit"
git commit -m $message_commit

# Pousser les modifications vers le repo distant
$lien_repo = Read-Host "Entrez l'URL du repo distant"
git push $lien_repo

# Cloner le repo d'un collègue
$dossier_clone = Read-Host "Entrez le nom du dossier pour cloner un repo"
New-Item -Path . -Name $dossier_clone -ItemType "directory"
Set-Location $dossier_clone

$lien_clone = Read-Host "Entrez l'URL du repo à cloner"
git clone $lien_clone

# Modifier le README du repo cloné
Set-Location (Split-Path $lien_clone -Leaf)
$texte_readme = Read-Host "Entrez le texte à ajouter au README"
Set-Content -Path "README.md" -Value $texte_readme

# Ajouter les modifications au Staging Area et committer
git add README.md
git commit -m $message_commit

# Pousser vers le repo distant
git push $lien_clone
