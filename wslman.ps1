$wsl_base_dir = '~/wsl/'
$wslman_path = $PSCommandPath
$u20 = 'https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz'

function main () {
    $ver = version
    "wslman version $ver"

    # verify wsl_base_dir exists
    if (Test-Path -Path $wsl_base_dir) {
        "wsl_base_dir found!"
    } else {
        "Creating wsl_base_dir at $wsl_base_dir"
        mkdir $wsl_base_dir
    }
    
    if (-Not (Test-Path -Path $wsl_base_dir)) {
        "A problem occured whilst creating wsl_base_dir"
    } else {
        "Entering $wsl_base_dir"
        
        Set-Location ~/wsl

        $cmd = $args[0]

        if($cmd -eq 'create') {
            "Creating a new WSL enviornment"
            if($args[1] -eq 'u20') {
                "Downloading ubuntu 20.04 (focal) latest"
                download($u20, $wsl_base_dir)
                "Downloading complete"
            }
        }
    }
}

function download($url, $local) {
    $client = New-Object System.Net.WebClient
    $client.DownloadFile('', $local)
}

function version() {
    $versionInfo = Get-FileHash -Algorithm SHA256 -Path $wslman_path
    return $versionInfo.Hash
}



main
