
post_install() {
    apply "(load-file \"$PEARL_PKGDIR/emacs.el\")" $HOME/.emacs
}

pre_remove() {
    unapply "(load-file \"$PEARL_PKGDIR/emacs.el\")" $HOME/.emacs
}
