class tools {
    $packages = ['python-software-properties', 'curl', 'imagemagick', 'build-essential', 'mc']
    
    package { $packages:
        ensure => installed,
    }
}
