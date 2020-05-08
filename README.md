# Helm Chart

First things first, this is meant to be used as a template or submodule, this doesn't deploys anything into your cluster, neither is meant to.

## How to use it 👪

### As a submodule

Make sure you are in the root folder of your project and run

`git submodule add --name helm-chart git@github.com:ydataai/helm-chart.git chart`

### As a template or bootstrap

You can be anywhere, i suggest you are in your local copy of the private charts

```
HC_NAME=<the name of your project>
curl -L -o ${HC_NAME} https://github.com/ydataai/helm-chart/archive/master.zip
unzip -a ${HC_NAME}.zip
rm -f ${HC_NAME}.zip
```

## How to customize it 🙅

In the root of the project, create a file called `chart.yaml` that will be used to override the default values in the submodule

You have to somehow provide the image attributes, either by yaml or argument, so make sure you include them

yaml example:

```yml
image:
  repository: your-image
  pullPolicy: Always
  tag: 1.0
```

Check the `values.yaml` for more that you can override. For example, you want to disable the autoscalling

```yml
autoscaling:
  enabled: false
```

## How to use it 🔨

### As a submodule

It's really simple, you just have to run helm in the root of your project and make sure you pass the required values, either using command line arguments or the file with overrides

Example using the yaml file

`helm upgrade <name of the project> chart --install --values chart.yaml`

### As a 

# About 👯‍♂️

With ❤️ from [YData](https://ydata.ai) [Development team](mailto://developers@ydata.ai)
