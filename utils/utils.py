import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


sns.set_style('darkgrid', {'axes.facecolor': '.9'})
sns.set_palette(palette='deep')
sns_c = sns.color_palette(palette='deep')


def test_train_split(threshold_date, df, show=True):
    mask = df['ds'] < pd.to_datetime(threshold_date)
    df_train = df[mask][['ds', 'y']]
    df_test = df[~ mask][['ds', 'y']]
    if show:
        fig, ax = plt.subplots()
        sns.lineplot(x='ds', y='y', label='y_train', data=df_train, ax=ax)
        sns.lineplot(x='ds', y='y', label='y_test', data=df_test, ax=ax)
        ax.axvline(pd.to_datetime(threshold_date), color=sns_c[3], linestyle='--', label='train test split')
        ax.legend(loc='upper left')
        ax.set(title='Dependent Variable', ylabel='')
    return df_train, df_test


def create_end_of_year_holiday():
    holidays = pd.DataFrame({
      'holiday': 'end_of_year',
      'ds': pd.to_datetime(
          ['2016-12-25', '2017-12-24', '2018-12-23', '2019-12-22']
      ),
      'lower_window': -7,
      'upper_window': 7,
    })
    return holidays
