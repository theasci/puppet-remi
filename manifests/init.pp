# Add remi repo
# enabled     - Integer for enabling remi repo (defaults to enabled)
# extras      - Integer for enabling/disabling remi-extras repo (defaults to disabled)
# php55       - Integer for enabling/disabling remi-php55 repo (defaults to disabled)
# includepkgs - String to whitelist packages for updates and installs (defaults to absent)
# exclude     - String to blacklist packages for updates and installs (defaults to absent)
class remi(
    $enabled     = 1,
    $extras      = 0,
    $php55       = 0,
    $includepkgs = absent,
    $exclude     = absent
) {
    yumrepo { 'remi':
        baseurl     => 'http://rpms.famillecollet.com/enterprise/$releasever/remi/$basearch/',
        mirrorlist  => 'http://rpms.famillecollet.com/enterprise/$releasever/remi/mirror',
        enabled     => $enabled,
        gpgcheck    => 1,
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
        descr       => 'Les RPM de remi pour Enterprise Linux $releasever - $basearch',
        includepkgs => $includepkgs,
        exclude     => $exclude,
    }

    yumrepo { 'remi-php55':
        baseurl     => 'http://rpms.famillecollet.com/enterprise/$releasever/php55/$basearch/',
        mirrorlist  => 'http://rpms.famillecollet.com/enterprise/$releasever/php55/mirror',
        enabled     => $php55,
        gpgcheck    => 1,
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
        descr       => 'Les RPM de remi de PHP 5.5 pour Enterprise Linux $releasever - $basearch'
        includepkgs => $includepkgs,
        exclude     => $exclude,
    }

    yumrepo { 'remi-extras':
        baseurl     => 'http://rpms.famillecollet.com/enterprise/$releasever/test/$basearch/',
        mirrorlist  => 'http://rpms.famillecollet.com/enterprise/$releasever/test/mirror',
        enabled     => $extras,
        gpgcheck    => 1,
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
        descr       => 'Les RPM de remi en test pour Enterprise Linux $releasever - $basearch'
        includepkgs => $includepkgs,
        exclude     => $exclude,
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-remi':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/remi/RPM-GPG-KEY-remi',
    }

    epel::rpm_gpg_key{ 'remi':
        path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
    }
}
