/*

== Definition: common::archive::download

Archive downloader with integrity verification.

Parameters:

- *$url: 
- *$digest_url:
- *$digest_string: Default value "" 
- *$digest_type: Default value "md5".
- *$timeout: Default value 120.
- *$src_target: Default value "/usr/src".
- *$allow_insecure: Default value false.

Example usage:

  common::archive::download {"apache-tomcat-6.0.26.tar.gz":
    ensure => present,
    url => "http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz",
  }
  
  common::archive::download {"apache-tomcat-6.0.26.tar.gz":
    ensure => present,
    digest_string => "f9eafa9bfd620324d1270ae8f09a8c89",
    url => "http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz",
  }
   
*/
define common::archive::download (
  $ensure=present, 
  $url, 
  $checksum=true,
  $digest_url="",
  $digest_string="",
  $digest_type="md5",
  $timeout=120,
  $src_target="/usr/src",
  $allow_insecure=false) {

  $insecure_arg = $allow_insecure ? {
    true => "-k",
    default => "",
  }

  if !defined(Package['curl']) {
    package{'curl':
      ensure => present,
    }
  }

  case $checksum {
    true : {
      case $digest_type {
        'md5','sha1','sha224','sha256','sha384','sha512' : { 
          $checksum_cmd = "cd ${src_target} && ${digest_type}sum -c ${name}.${digest_type}" 
        }
        default: { fail "Unimplemented digest type" }
      }
    
      if $digest_url != "" and $digest_content != "" {
        fail "digest_url and digest_content should not be used together !"
      }
    
      if $digest_content == "" {
    
        case $ensure {
          present: {
    
            if $digest_url == "" {
              $digest_src = "${url}.${digest_type}"
            } else {
              $digest_src = $digest_url
            }
    
            exec {"download digest of archive $name":
              command => "curl ${insecure_arg} -o ${src_target}/${name}.${digest_type} ${digest_src}",
              creates => "${src_target}/${name}.${digest_type}",
              timeout => $timeout,
              notify  => Exec["download archive $name and check sum"],
              require => Package["curl"],
            }
    
          }
          absent: {
            file{"${src_target}/${name}.${digest_type}":
              ensure => absent,
              purge => true,
              force => true,
            }
          }
        }
      }
    
      if $digest_string != "" {
        case $ensure {
          present: {
            file {"${src_target}/${name}.${digest_type}":
              ensure => $ensure,
              content => "${digest_string} *${name}",
              notify => Exec["download archive $name and check sum"],
            }
          }
          absent: {
            file {"${src_target}/${name}.${digest_type}":
              ensure => absent,
              purge => true,
              force => true,
            }
          }
        }
      }
    }
    false :  { notice "No checksum for this archive" }
    default: { fail ( "Unknown checksum value: '${checksum}'" ) }
  }
 
  case $ensure {
    present: {
      $on_error = "(rm -f ${src_target}/${name} ${src_target}/${name}.${digest_type} && exit 1)"
      exec {"download archive $name and check sum":
        command => $checksum ? {
          true => "(curl ${insecure_arg} -o ${src_target}/${name} ${url} && ${checksum_cmd}) || ${on_error}",
          false => "curl ${insecure_arg} -o ${src_target}/${name} ${url}",
          default => fail ( "Unknown checksum value: '${checksum}'" ),
        },
        creates => "${src_target}/${name}",
        logoutput => true,
        timeout => $timeout,
        require => Package["curl"],
        refreshonly => $checksum ? {
          true => true,
          default => undef,
        },
      }
    }
    absent: {
      file {"${src_target}/${name}":
        ensure => absent,
        purge => true,
        force => true,
      }
    }
    default: { fail ( "Unknown ensure value: '${ensure}'" ) }
  }
}
