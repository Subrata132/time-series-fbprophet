import numpy as np
import pandas as pd

np.random.seed(seed=42)


class DataGenerator:
    def __init__(self,
                 start_date='2016-06-30',
                 end_date='2020-10-31',
                 freq='W'):
        self.start_date = start_date
        self.end_date = end_date
        self.freq = freq
        self.date_range = pd.date_range(start=self.start_date,
                                        end=self.end_date,
                                        freq=self.freq)

    def get_data(self):
        df = pd.DataFrame(data={'ds': self.date_range})
        df['day_of_month'] = df['ds'].dt.day
        df['month'] = df['ds'].dt.month
        df['daysinmonth'] = df['ds'].dt.daysinmonth
        df['week'] = df['ds'].dt.week
        df['trend'] = np.power(df.index.values + 1, 2 / 5) + np.log(df.index.values + 3)
        df['monthly_seas'] = np.cos(2 * np.pi * df['day_of_month'] / df['daysinmonth'])
        df['yearly_seas'] = 1.2 * (np.sin(np.pi * df['month'] / 3) + np.cos(2 * np.pi * df['month'] / 4))
        df['end_of_year'] = - 8.5 * np.exp(- ((df['week'] - 51.5) / 1.0) ** 2)
        df['noise'] = np.random.normal(loc=0.0, scale=0.3, size=df.shape[0])
        df['y'] = df['trend'] + df['monthly_seas'] + df['yearly_seas'] + df['end_of_year'] + df['noise']
        return df
