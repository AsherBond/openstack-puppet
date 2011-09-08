class glance::images {

  file { "initial_images.sh":
    path => "/var/lib/glance/initial_images.sh",
    ensure  => present,
    owner   => "glance",
    mode    => 0755,
    source  => "puppet:///modules/glance/initial_images.sh",
    require => Package["glance"]
  }
  
  exec { "install-images":
    command => "/var/lib/glance/initial_images.sh",
    # the initial install script does an su
    #user => "nova",
    path => ["/bin", "/usr/bin"],
    # If we are using swift, then we won't do image import
    unless => "test -f /var/lib/glance/images/1 || grep default_store /etc/glance/glance-api.conf | grep swift",
    require => [
      Service["glance-api"],
      Service["nova-api"],
      Service["glance-registry"],
      File["initial_images.sh"]
    ]
  }

}
  
