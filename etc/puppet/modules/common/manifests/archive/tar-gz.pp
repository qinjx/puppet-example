define common::archive::tar-gz($source, $target) {
  exec {"$name unpack":
    command => "curl ${source} | tar -xzf - -C ${target} && touch ${name}",
    creates => $name,
    require => Package[curl],
  }
}
