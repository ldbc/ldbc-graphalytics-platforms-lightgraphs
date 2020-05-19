package science.atlarge.graphalytics.julia.algorithms.lcc;

import science.atlarge.graphalytics.domain.graph.Graph;
import science.atlarge.graphalytics.execution.RunSpecification;
import science.atlarge.graphalytics.julia.JuliaConfiguration;
import science.atlarge.graphalytics.julia.JuliaJob;

public class LocalClusteringCoefficientJob extends JuliaJob {
    public LocalClusteringCoefficientJob(RunSpecification runSpecification, JuliaConfiguration platformConfig, String inputPath, String outputPath, Graph benchmarkGraph) {
        super(runSpecification, platformConfig, inputPath, outputPath, benchmarkGraph);
    }

    @Override
    protected void appendAlgorithmParameters() {
        commandLine.addArgument("--algorithm");
        commandLine.addArgument("lcc");
    }
}
