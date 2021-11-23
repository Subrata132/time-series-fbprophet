import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns


sns.set_style('darkgrid', {'axes.facecolor': '.9'})
sns.set_palette(palette='deep')
sns_c = sns.color_palette(palette='deep')


def line_plot(df, x_axis, y_axis):
    fig, ax = plt.subplots()
    sns.lineplot(x=x_axis, y=y_axis, data=df, ax=ax)
    ax.set(title='Raw Data', xlabel='date', ylabel='')


def plot_all_component(df):
    fig, ax = plt.subplots()
    sns.lineplot(x='ds', y='y', label='y', data=df, ax=ax)
    sns.lineplot(x='ds', y='trend', label='trend', data=df, alpha=0.7, ax=ax)
    sns.lineplot(x='ds', y='monthly_seas', label='monthly_seas', data=df, alpha=0.7, ax=ax)
    sns.lineplot(x='ds', y='yearly_seas', label='yearly_seas', data=df, alpha=0.7, ax=ax)
    sns.lineplot(x='ds', y='end_of_year', label='end_of_year', data=df, alpha=0.7, ax=ax)
    sns.lineplot(x='ds', y='noise', label='noise', data=df, alpha=0.7, ax=ax)
    ax.legend(loc='upper left')
    ax.set(title='Raw Data -  Components', xlabel='date', ylabel='')


def plot_prediction(forecast,
                    train_df,
                    test_df,
                    threshold_date):
    threshold_date = pd.to_datetime(threshold_date)
    mask = forecast['ds'] < threshold_date
    forecast_train = forecast[mask]
    forecast_test = forecast[~ mask]
    fig, ax = plt.subplots()

    ax.fill_between(
        x=forecast['ds'],
        y1=forecast['yhat_lower'],
        y2=forecast['yhat_upper'],
        color=sns_c[2],
        alpha=0.25,
        label=r'0.95 credible_interval'
    )

    sns.lineplot(x='ds', y='y', label='y_train', data=train_df, ax=ax)
    sns.lineplot(x='ds', y='y', label='y_test', data=test_df, ax=ax)
    sns.lineplot(x='ds', y='yhat', label='y_hat', data=forecast, ax=ax)
    ax.axvline(threshold_date, color=sns_c[3], linestyle='--', label='train test split')
    ax.legend(loc='upper left')
    ax.set(title='Dependent Variable', ylabel='')