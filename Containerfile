FROM gentoo/portage:latest AS portage

FROM gentoo/stage3:systemd

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN rm /etc/portage/binrepos.conf/gentoobinhost.conf && \
    getuto

COPY scripts/enable_portage_feature.sh /usr/local/bin/enable_portage_feature
COPY scripts/emerge_wrapper.sh /usr/local/bin/emerge_wrapper

RUN sed -i -e 's/COMMON_FLAGS=.*/COMMON_FLAGS="-mcpu=cortex-a72 -ftree-vectorize -O2 -pipe -fomit-frame-pointer"/g' /etc/portage/make.conf && \
    enable_portage_feature getbinpkg

RUN emerge_wrapper app-eselect/eselect-repository app-portage/gentoolkit dev-util/pkgcheck dev-util/pkgdev

RUN emerge_wrapper dev-vcs/git && \
    eselect repository add fluentoo git git@github.com:fluentoo/fluentoo-overlay.git && \
    emaint sync --repo fluentoo

RUN eselect profile set custom/linux/arm64/23.0/musl/hardened/selinux/systemd && \
    eselect news list && \
    eselect news read all > /dev/null 2&>1 && \
    eselect news purge
