from statsmodels.tsa.seasonal import seasonal_decompose
import seaborn as sns
import matplotlib.pyplot as plt


class SeasonalDecomposition:
    def __init__(self,
                 df,
                 index_column,
                 model='additive'):
        self.df = df
        self.index_column = index_column
        self.model = model
        self._decomposer()

    def _decomposer(self):
        self.decomposition_object = seasonal_decompose(
                x=self.df.set_index(self.index_column),
                model=self.model
            )

    def decomposed_series(self):
        sns_c = sns.color_palette(palette='deep')
        fig, ax = plt.subplots(4, 1, figsize=(12, 12))
        self.decomposition_object.observed.plot(ax=ax[0])
        ax[0].set(title='observed')
        self.decomposition_object.trend.plot(label='fit', ax=ax[1])
        self.df[['ds', 'trend']].set_index('ds').plot(c=sns_c[1], ax=ax[1])
        ax[1].legend(loc='lower right')
        ax[1].set(title='trend')
        self.decomposition_object.seasonal.plot(label='fit', ax=ax[2])
        self.df.assign(seasonal=lambda x: x['yearly_seas'] + x['monthly_seas'] + x['end_of_year'])[['ds', 'seasonal']] \
            .set_index('ds') \
            .plot(c=sns_c[2], ax=ax[2])
        ax[2].legend(loc='lower right')
        ax[2].set(title='seasonal')
        self.decomposition_object.resid.plot(label='fit', ax=ax[3])
        self.df[['ds', 'noise']].set_index('ds').plot(c=sns_c[3], ax=ax[3])
        ax[3].legend(loc='lower right')
        ax[3].set(title='residual')
        fig.suptitle('Time Series Decomposition', y=1.01)
        plt.tight_layout()
