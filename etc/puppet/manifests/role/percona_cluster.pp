class role_percona_cluster {
  yum::repo::conf {
    "percona":
  }

  include percona::cluster::install, percona::cluster::service
}