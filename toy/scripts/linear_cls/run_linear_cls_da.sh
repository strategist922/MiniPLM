#! /bin/bash

BASE_PATH=${1-"/home/MiniLLM"}

# type
TYPE="toy"
# hp
LR=0.005
BATCH_SIZE=-1
# runtime
SAVE_PATH="${BASE_PATH}/results/${TYPE}"
# seed
SEED=10


OPTS=""
# type
OPTS+=" --type ${TYPE}"
# model
OPTS+=" --model-type linear_cls_da"
OPTS+=" --base-path ${BASE_PATH}"
OPTS+=" --input-dim 128"
# data
OPTS+=" --train-num 1024"
OPTS+=" --dev-num 512"
OPTS+=" --test-num 512"
OPTS+=" --train-mu 0.0"
OPTS+=" --train-sigma 2.0"
OPTS+=" --dev-mu 0.5"
OPTS+=" --dev-sigma 2.0"
# hp
OPTS+=" --lr ${LR}"
OPTS+=" --lr-alpha 0.0002"
OPTS+=" --batch-size ${BATCH_SIZE}"
OPTS+=" --epochs 10000"
OPTS+=" --log-interval 1000"
OPTS+=" --alpha-update-interval 10"
OPTS+=" --lam 0.00"
# runtime
OPTS+=" --save ${SAVE_PATH}"
# seed
OPTS+=" --seed ${SEED}"


export NCCL_DEBUG=""
# export WANDB_DISABLED=True
export TF_CPP_MIN_LOG_LEVEL=3
export PYTHONPATH=${BASE_PATH}
export OMP_NUM_THREADS=16
CMD="python3 ${BASE_PATH}/toy/linear_cls/main.py ${OPTS} $@"

echo ${CMD}
echo "PYTHONPATH=${PYTHONPATH}"
mkdir -p ${SAVE_PATH}
${CMD}