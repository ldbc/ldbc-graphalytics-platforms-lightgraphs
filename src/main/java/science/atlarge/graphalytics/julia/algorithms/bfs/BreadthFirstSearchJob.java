package science.atlarge.graphalytics.julia.algorithms.bfs;

import science.atlarge.graphalytics.domain.algorithms.BreadthFirstSearchParameters;
import science.atlarge.graphalytics.domain.graph.Graph;
import science.atlarge.graphalytics.execution.RunSpecification;
import science.atlarge.graphalytics.julia.JuliaConfiguration;
import science.atlarge.graphalytics.julia.JuliaJob;

public class BreadthFirstSearchJob extends JuliaJob {
    public BreadthFirstSearchJob(RunSpecification runSpecification, JuliaConfiguration platformConfig, String inputPath, String outputPath, Graph benchmarkGraph) {
        super(runSpecification, platformConfig, inputPath, outputPath, benchmarkGraph);
    }

    @Override
    protected void appendAlgorithmParameters() {
        commandLine.addArgument("--algorithm");
        commandLine.addArgument("bfs");

        BreadthFirstSearchParameters params =
                (BreadthFirstSearchParameters) runSpecification.getBenchmarkRun().getAlgorithmParameters();
        commandLine.addArgument("--source-vertex");
        commandLine.addArgument(Long.toString(params.getSourceVertex()));
    }
}
