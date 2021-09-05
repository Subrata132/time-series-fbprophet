import matplotlib.pyplot as plt
import seaborn as sns


def line_plot(df, x_axis, y_axis):
    fig, ax = plt.subplots()
    sns.lineplot(x=x_axis, y=y_axis, data=df, ax=ax)
    ax.set(title='Raw Data', xlabel='date', ylabel='')
    plt.show()