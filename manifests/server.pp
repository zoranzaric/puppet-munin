class munin::server {
	package{ "munin": ensure => installed }

	if $munin_vhost {
		$vhost = $munin_vhost
	} else {
		$vhost = 'munin'
	}

	if $munin_domain {
		$domain = $munin_domain
	} else {
		$domain = 'example.com'
	}

	import "vhosts"
	vhosts::vhost{"${vhost}.${domain}":
		vhost => $vhost,
		domain => $domain,
		vhost_user => "munin",
		vhost_group => "munin",
	}

	file{"/etc/munin/conf.d":
		ensure => directory,
		require => Package['munin'],
	}

	file{"/etc/munin/munin.conf":
		ensure => present,
		content => template('munin/munin.conf.erb'),
		require => Package['munin'],
	}

	File <<| tag == 'munin_host' |>>
}

