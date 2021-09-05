from utils.data_generator import DataGenerator
from utils.visualization import line_plot


def main():
    data_gen = DataGenerator()
    data_df = data_gen.get_data()
    line_plot(data_df, 'ds', 'y')


if __name__ == '__main__':
    main()