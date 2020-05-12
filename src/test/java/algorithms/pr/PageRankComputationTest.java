package algorithms.pr;

import science.atlarge.graphalytics.validation.GraphStructure;
import science.atlarge.graphalytics.validation.algorithms.pr.PageRankOutput;
import science.atlarge.graphalytics.validation.algorithms.pr.PageRankValidationTest;

import java.util.HashMap;
import java.util.Map;

public class PageRankComputationTest extends PageRankValidationTest {

    @Override
    public PageRankOutput executeDirectedPageRank(GraphStructure graph, science.atlarge.graphalytics.domain.algorithms.PageRankParameters parameters) throws Exception {
        return null;
    }

    @Override
    public PageRankOutput executeUndirectedPageRank(GraphStructure graph, science.atlarge.graphalytics.domain.algorithms.PageRankParameters parameters) throws Exception {
        return null;
    }

    private PageRankOutput executePageRank() {
        final Map<Long, Double> output = new HashMap<>();
        return new PageRankOutput(output);
    }
}
