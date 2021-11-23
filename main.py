from utils.data_generator import DataGenerator
from utils.visualization import line_plot, plot_all_component, plot_prediction
from utils.utils import test_train_split
from model import Model
import matplotlib.pyplot as plt


def main():
    data_gen = DataGenerator()
    data_df = data_gen.get_data()
    line_plot(data_df, 'ds', 'y')
    plot_all_component(data_df)
    train_df, test_df = test_train_split('2019-11-01', data_df)
    model = Model(train_df=train_df).fit_model()
    future = model.make_future_dataframe(periods=test_df.shape[0], freq='W')
    forecast = model.predict(df=future)
    plot_prediction(forecast=forecast,
                    train_df=train_df,
                    test_df=test_df,
                    threshold_date='2019-11-01')
    plt.show()


if __name__ == '__main__':
    main()