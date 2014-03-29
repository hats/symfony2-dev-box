class node-js {

    class { 'nodejs':
        version => 'stable',
    }

    package { 'bower':
          ensure => present,
          provider => 'npm',
    }
    
}
