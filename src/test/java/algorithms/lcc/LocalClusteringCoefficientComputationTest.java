package algorithms.lcc;

import science.atlarge.graphalytics.validation.GraphStructure;
import science.atlarge.graphalytics.validation.algorithms.lcc.LocalClusteringCoefficientOutput;
import science.atlarge.graphalytics.validation.algorithms.lcc.LocalClusteringCoefficientValidationTest;

import java.util.HashMap;
import java.util.Map;

public class LocalClusteringCoefficientComputationTest extends LocalClusteringCoefficientValidationTest {
    @Override
    public LocalClusteringCoefficientOutput executeDirectedLocalClusteringCoefficient(GraphStructure graph) throws Exception {
        return null;
    }

    @Override
    public LocalClusteringCoefficientOutput executeUndirectedLocalClusteringCoefficient(GraphStructure graph) throws Exception {
        return null;
    }

    private LocalClusteringCoefficientOutput executeLocalCLusteringCoefficient() {
        final Map<Long, Double> output = new HashMap<>();
        return new LocalClusteringCoefficientOutput(output);
    }
}
