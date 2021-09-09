from utils.data_generator import DataGenerator
from utils.time_series_analysis import SeasonalDecomposition
from utils.visualization import line_plot
import matplotlib.pyplot as plt


def main():
    data_gen = DataGenerator()
    data_df = data_gen.get_data()
    line_plot(data_df, 'ds', 'y')
    # SeasonalDecomposition(df=data_df, index_column='ds').decomposed_series()
    plt.show()


if __name__ == '__main__':
    main()