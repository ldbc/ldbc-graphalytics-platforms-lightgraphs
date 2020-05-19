package science.atlarge.graphalytics.julia.algorithms.pr;

import science.atlarge.graphalytics.domain.algorithms.PageRankParameters;
import science.atlarge.graphalytics.domain.graph.Graph;
import science.atlarge.graphalytics.execution.RunSpecification;
import science.atlarge.graphalytics.julia.JuliaConfiguration;
import science.atlarge.graphalytics.julia.JuliaJob;

public class PageRankJob extends JuliaJob {


    public PageRankJob(RunSpecification runSpecification, JuliaConfiguration platformConfig, String inputPath, String outputPath, Graph benchmarkGraph) {
        super(runSpecification, platformConfig, inputPath, outputPath, benchmarkGraph);
    }

    @Override
    protected void appendAlgorithmParameters() {
        commandLine.addArgument("--algorithm");
        commandLine.addArgument("pr");

        PageRankParameters params =
                (PageRankParameters) runSpecification.getBenchmarkRun().getAlgorithmParameters();
        commandLine.addArgument("--damping-factor");
        commandLine.addArgument(Float.toString(params.getDampingFactor()));
        commandLine.addArgument("--max-iteration");
        commandLine.addArgument(Integer.toString(params.getNumberOfIterations()));
    }
}
