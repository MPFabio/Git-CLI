#!/bin/bash

# Vérifier si curl est installé, sinon l'installer
if ! type -p curl > /dev/null; then
    echo "Installation de curl..."
    sudo apt update && sudo apt install curl -y
fi

# Installer GitHub CLI
echo "Installation de GitHub CLI..."
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh -y

# Authentification GitHub CLI
echo "Authentification avec GitHub CLI..."
gh auth login

# Créer un dossier pour le nouveau repo
echo "Création d'un dossier pour le repo..."
read -p "Entrez le nom du dossier à créer : " nom_dossier
mkdir $nom_dossier && cd $nom_dossier

# Créer un repo GitHub
echo "Création d'un nouveau repo GitHub..."
gh repo create

# Se déplacer dans le repo et modifier le README
echo "Modification du README..."
read -p "Entrez le texte à ajouter au README : " texte_readme
echo "$texte_readme" >> README.md

# Ajouter les modifications au Staging Area
git add README.md

# Commit avec un message
read -p "Entrez un message pour le commit : " message_commit
git commit -m "$message_commit"

# Pousser les modifications vers le repo distant
read -p "Entrez l'URL du repo distant : " lien_repo
git push $lien_repo

# Cloner le repo d'un collègue
read -p "Entrez le nom du dossier pour cloner un repo : " dossier_clone
mkdir $dossier_clone && cd $dossier_clone

read -p "Entrez l'URL du repo à cloner : " lien_clone
git clone $lien_clone

# Se déplacer dans le repo cloné et modifier le README
cd $(basename $lien_clone .git)
echo "$texte_readme" > README.md
git add README.md

# Commit avec un message
git commit -m "$message_commit"

# Pousser vers le repo distant
git push $lien_clone
