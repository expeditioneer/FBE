FROM gentoo/portage:latest AS portage

FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

COPY config/gentoobinhost.conf /etc/portage/binrepos.conf/gentoobinhost.conf
RUN getuto

COPY scripts/enable_portage_feature.sh /usr/local/bin/enable_portage_feature
COPY scripts/emerge_wrapper.sh /usr/local/bin/emerge_wrapper

RUN enable_portage_feature getbinpkg && \
    enable_portage_feature binpkg-request-signature

RUN emerge_wrapper app-eselect/eselect-repository  app-portage/gentoolkit dev-util/pkgcheck dev-util/pkgdev

RUN eselect profile set default/linux/arm64/23.0/hardened/selinux/systemd && \
    eselect news read all && eselect news purge