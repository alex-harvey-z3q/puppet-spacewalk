class spacewalk::repos (
  $yumrepos = $spacewalk::params::yumrepos,
) {
  create_resources(yumrepo, $yumrepos)
}
