#! /bin/bash

BASE_PATH=${1-"/home/MiniLLM"}

# type
TYPE="toy"
# hp
LR=0.05
BATCH_SIZE=-1
# runtime
SAVE_PATH="${BASE_PATH}/results/${TYPE}"
# seed
SEED=30
SEED_DATA=20


OPTS=""
# type
OPTS+=" --type ${TYPE}"
# model
OPTS+=" --model-type trm"
OPTS+=" --base-path ${BASE_PATH}"
OPTS+=" --input-dim 128"
OPTS+=" --num-head 4"
# data
OPTS+=" --train-num 4000"
OPTS+=" --dev-num 500"
OPTS+=" --test-num 500"
OPTS+=" --ratio-1-2 1.3"
OPTS+=" --data-names addition"
# OPTS+=" --load-toy-data 1"
# hp
OPTS+=" --lr ${LR}"
OPTS+=" --batch-size ${BATCH_SIZE}"
OPTS+=" --epochs 2000"
OPTS+=" --log-interval 100"
OPTS+=" --lam 0.0"
OPTS+=" --clip-grad -1"
# runtime
OPTS+=" --save ${SAVE_PATH}"
# seed
OPTS+=" --seed ${SEED}"
OPTS+=" --seed-data ${SEED_DATA}"


export NCCL_DEBUG=""
# export WANDB_DISABLED=True
export TF_CPP_MIN_LOG_LEVEL=3
export PYTHONPATH=${BASE_PATH}
export OMP_NUM_THREADS=16
CMD="python3 ${BASE_PATH}/toy/trm/main.py ${OPTS} $@"

echo ${CMD}
echo "PYTHONPATH=${PYTHONPATH}"
mkdir -p ${SAVE_PATH}
${CMD}
