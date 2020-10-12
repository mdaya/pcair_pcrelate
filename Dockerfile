FROM uwgac/topmed-master:2.6.0

# Install scripts
COPY run_genesis_pcair_pcrelate.sh /home/analyst/
RUN chmod a+x /home/analyst/run_genesis_pcair_pcrelate.sh
COPY GENESIS_PCAIR_PCRELATE.R /home/analyst/
