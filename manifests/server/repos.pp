class spacewalk::server::repos (
  $yumrepos = $spacewalk::params::yumrepos,
) {
  create_resources(yumrepo, $yumrepos)
}
