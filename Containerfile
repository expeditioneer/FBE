FROM gentoo/portage:latest AS portage

FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

COPY config/gentoobinhost.conf /etc/portage/binrepos.conf/gentoobinhost.conf
COPY scripts/enable_portage_feature.sh /usr/local/bin/enable_portage_feature

RUN enable_portage_feature getbinpkg && \
    enable_portage_feature binpkg-request-signature

RUN getuto
