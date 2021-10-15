$wsl_base_dir = 'C:\Users\jared\wsl\'
$wslman_path = $PSCommandPath
$u20 = 'https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz'
$cmd = $args[0]
$var1 = $args[1]

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
        
        Set-Location $wsl_base_dir

        # check which command was passed
        if($cmd -eq 'create') {
            create
        }

        if($cmd -eq 'clean') {
            clean
        }

    }
}

function clean() {
    Remove-Item *.tar.gz
}

function create() {
    "Creating a new WSL enviornment"
            
    $download_link = ''
    $local_filename = ''

    if($var1 -eq 'u20') {
        $download_link = $u20
        $local_filename = 'ubuntu.focal.tar.gz'
    }

    if(-Not ($download_link -eq '')) {
        download $download_link $local_filename
    }
}

function download($dl_url, $dl_file) {
    $client = New-Object System.Net.WebClient

    $dl_local_path = $wsl_base_dir + $dl_file
    "DOWNLOAD $dl_url TO $dl_local_path"

    $client.DownloadFile($dl_url, $dl_local_path)
}

function version() {
    $versionInfo = Get-FileHash -Algorithm SHA256 -Path $wslman_path
    return $versionInfo.Hash
}

main
