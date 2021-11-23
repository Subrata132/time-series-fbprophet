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
