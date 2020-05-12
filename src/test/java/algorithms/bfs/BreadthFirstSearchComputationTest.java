package algorithms.bfs;

import science.atlarge.graphalytics.domain.algorithms.BreadthFirstSearchParameters;
import science.atlarge.graphalytics.validation.GraphStructure;
import science.atlarge.graphalytics.validation.algorithms.bfs.BreadthFirstSearchOutput;
import science.atlarge.graphalytics.validation.algorithms.bfs.BreadthFirstSearchValidationTest;

import java.util.HashMap;
import java.util.Map;

public class BreadthFirstSearchComputationTest extends BreadthFirstSearchValidationTest {

    @Override
    public BreadthFirstSearchOutput executeDirectedBreadthFirstSearch(GraphStructure graph, BreadthFirstSearchParameters parameters) throws Exception {
        return null;
    }

    @Override
    public BreadthFirstSearchOutput executeUndirectedBreadthFirstSearch(GraphStructure graph, BreadthFirstSearchParameters parameters) throws Exception {
        return null;
    }

    private BreadthFirstSearchOutput executeBreadthFirstSearch() {
        final Map<Long, Long> output = new HashMap<>();
        return new BreadthFirstSearchOutput(output);
    }

}
