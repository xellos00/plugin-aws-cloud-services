FROM python:3.8

ENV PYTHONUNBUFFERED 1
ENV CLOUDONE_PORT 50051
ENV SERVER_TYPE grpc
ENV PKG_DIR /tmp/pkg
ENV SRC_DIR /tmp/src

COPY pkg/*.txt ${PKG_DIR}/
RUN pip install --upgrade pip && \
    pip install --upgrade --use-deprecated=legacy-resolver -r ${PKG_DIR}/pip_requirements.txt && \
    pip install --upgrade --pre spaceone-core spaceone-api

COPY src ${SRC_DIR}

WORKDIR ${SRC_DIR}
RUN python3 setup.py install && \
    rm -rf /tmp/*

EXPOSE ${CLOUDONE_PORT}

ENTRYPOINT ["spaceone"]
CMD ["grpc", "spaceone.inventory"]
