ARG FROM_IMAGE
ARG FROM_VARIANT

FROM ${FROM_IMAGE}:${FROM_VARIANT}

ARG USERNAME
ARG UID
ARG GID

USER root

# This magic sed edits are very important
# They allow to build a container with different UID/GID ot of a base
ENV OLD_GID="1000"
RUN sed -i -e "s/\(${USERNAME}:[^:]*:\)[^:]*:[^:]*/\1${UID}:${GID}/" /etc/passwd; \
    sed -i -e "s/\([^:]*:[^:]*:\)${OLD_GID}:/\1${GID}:/" /etc/group; \
    chown -R $UID:$GID /home/$USERNAME

# copy code-server entrypoint
COPY ./entrypoint.sh /bin/entrypoint
RUN chmod +x /bin/entrypoint
ENTRYPOINT [ "/bin/entrypoint" ]

USER ${USERNAME}