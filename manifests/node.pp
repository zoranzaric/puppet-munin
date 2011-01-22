class munin::node {
	package{ "munin-node": ensure => installed }

	if $munin_allows {
		$allow = $munin_allows
	} else {
		$allows = ['allow ^127\.0\.0\.1$']
	}

	service { "munin-node":
		ensure => running,
		enable => true,
	}

	file{ "/etc/munin/munin-node.conf":
		ensure => present,
		require => Package["munin-node"],
		content => template('munin/munin-node.conf.erb'),
	}

	@@file{ "/etc/munin/conf.d/${fqdn}.conf":
		ensure => present,
		require => File["/etc/munin/conf.d/"],
		content => template('munin/node.conf.erb'),
		tag => 'munin_node',
	}

	file{"/usr/share/munin/plugins/du_vhost_":
		ensure => present,
		source => "puppet://munin/du_vhost_",
		require => Package["munin-node"],
	}

	file{"/usr/share/munin/plugins/du_domain_":
		ensure => present,
		source => "puppet://munin/du_domain_",
		require => Package["munin-node"],
	}

	file{"/usr/share/munin/plugins/vnstat":
		ensure => present,
		source => "puppet://munin/vnstat",
		require => Package["munin-node"],
	}

	file{"/usr/share/munin/plugins/vnstat_day":
		ensure => present,
		source => "puppet://munin/vnstat_day",
		require => Package["munin-node"],
	}

	file{"/usr/share/munin/plugins/vnstat_month":
		ensure => present,
		source => "puppet://munin/vnstat_month",
		require => Package["munin-node"],
	}

}

