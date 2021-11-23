from fbprophet import Prophet
from utils.utils import create_end_of_year_holiday


def build_model():
    model = Prophet(
        yearly_seasonality=True,
        weekly_seasonality=False,
        daily_seasonality=False,
        holidays=create_end_of_year_holiday(),
        interval_width=0.95,
        mcmc_samples=500
    )

    model.add_seasonality(
        name='monthly',
        period=30.5,
        fourier_order=5
    )

    return model


class Model:
    def __init__(self, train_df):
        self.train_df = train_df
        self.model = build_model()

    def fit_model(self):
        return self.model.fit(self.train_df)
