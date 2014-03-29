class postgresql 
{
    exec { 'psql_add_repo':
        command => '/usr/bin/add-apt-repository ppa:chris-lea/postgresql-9.3'
    }

    exec { 'psql_update_repo':
        command => '/usr/bin/apt-get update',
        require => Exec['psql_add_repo']
    }

    package 
    { 
        "postgresql-9.3":
            ensure  => present,
            require => Exec['psql_update_repo']
    }

    package
    {
        "postgresql-client":
        ensure  => present
    }
    
    # http://stackoverflow.com/questions/15949783/postgresql-is-being-installed-with-sql-ascii-using-puppet
    exec { 'psql_utf8_fix':
        require => Package["postgresql-9.3"],
        command => 'pg_dropcluster --stop 9.3 main ; pg_createcluster --start --locale en_US.UTF-8 9.3 main',
        unless  => 'sudo -u postgres psql -t -c "\l" | grep template1 | grep -q UTF',
        path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    }
    
    service 
    { 
        "postgresql":
            enable => false,
            ensure => stopped,
            require => Package["postgresql-9.3"]
    }
}