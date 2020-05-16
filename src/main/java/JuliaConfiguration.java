import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import science.atlarge.graphalytics.configuration.ConfigurationUtil;
import science.atlarge.graphalytics.configuration.GraphalyticsExecutionException;

import java.nio.file.Paths;

public class JuliaConfiguration {

    protected static final Logger LOG = LogManager.getLogger();

    private static final String BENCHMARK_PROPERTIES_FILE = "benchmark.properties";
    private static final String NUM_THREADS_KEY = "platform.graphblas.num-threads";

    private String loaderPath;
    private String unloaderPath;
    private String executablePath;
    private String terminatorPath;
    private int numThreads = 1;

    public JuliaConfiguration() {
    }

    public String getLoaderPath() {
        return loaderPath;
    }

    public void setLoaderPath(String loaderPath) {
        this.loaderPath = loaderPath;
    }

    public String getUnloaderPath() {
        return unloaderPath;
    }

    public void setUnloaderPath(String unloaderPath) {
        this.unloaderPath = unloaderPath;
    }

    public String getExecutablePath() {
        return executablePath;
    }

    public void setExecutablePath(String executablePath) {
        this.executablePath = executablePath;
    }

    public String getTerminatorPath() {
        return terminatorPath;
    }

    public void setTerminatorPath(String terminatorPath) {
        this.terminatorPath = terminatorPath;
    }

    public int getNumThreads() {
        return numThreads;
    }

    public void setNumThreads(int numThreads) {
        this.numThreads = numThreads;
    }

    public static JuliaConfiguration parsePropertiesFile() {
        JuliaConfiguration platformConfig = new JuliaConfiguration();

        Configuration configuration = null;
        try {
            configuration = ConfigurationUtil.loadConfiguration(BENCHMARK_PROPERTIES_FILE);
        } catch (Exception e) {
            LOG.warn(String.format("Failed to load configuration from %s", BENCHMARK_PROPERTIES_FILE));
            throw new GraphalyticsExecutionException("Failed to load configuration. Benchmark run aborted.", e);
        }

        String loaderPath = Paths.get("./bin/sh/load-graph.sh").toString();
        platformConfig.setLoaderPath(loaderPath);

        String unloaderPath = Paths.get("./bin/sh/unload-graph.sh").toString();
        platformConfig.setUnloaderPath(unloaderPath);

        String executablePath = Paths.get("./bin/sh/execute-job.sh").toString();
        platformConfig.setExecutablePath(executablePath);

        String terminatorPath = Paths.get("./bin/sh/terminate-job.sh").toString();
        platformConfig.setTerminatorPath(terminatorPath);

        Integer numThreads = configuration.getInteger(NUM_THREADS_KEY, null);
        if (numThreads != null) {
            platformConfig.setNumThreads(numThreads);
        } else {
            platformConfig.setNumThreads(1);
        }

        return platformConfig;
    }

}
