# Helm Chart

base chart that is meant to be used as submodule

🤔 When we introduce helm repo, this will be probably converted in a template for helm 🙏

## How to include it 👪

Make sure you are in the root folder of your project and run

`git submodule add --name helm-chart git@github.com:ydataai/helm-chart.git chart`

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

It's really simple, you just have to run helm in the root of your project and make sure you pass the required values, either using command line arguments or the file with overrides

Example using the yaml file

`helm upgrade <name of the project> chart --install --values chart.yaml`
