class host-network::install {

  file { "/etc/network/interfaces":
    content => template("network/interfaces.erb"),
    mode    => 0644,
    backup  => true,
    notify  => Exec["restart_network"]
  }

  exec { "restart_network":
    command     => "/etc/init.d/networking restart",
    path        => [ "/bin", "/usr/bin" ],
    refreshonly => true
  }
}
  
