class spacewalk::server::repos (
  $yumrepos = $spacewalk::server::yumrepos,
) {
  create_resources(yumrepo, $yumrepos)
}
