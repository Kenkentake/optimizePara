#include <mpi.h>
#include <mpi-ext.h>
#include <stdio.h>
#include <string.h>
int main(int argc, char **argv) {
    int world_size, universe_size;
    int *universe_size_p;
    int flag;
    MPI_Status status;
                        
    MPI_Comm worker_comm;
    char master_port[MPI_MAX_PORT_NAME] = "";
    char worker_port[MPI_MAX_PORT_NAME] = "";
    
    // 各コミュニケーターのルートランク
    const int self_root   = 0; // SELF   (MPI_COMM_SELF)
    const int master_root = 0; // MASTER (MPI_COMM_WORLD)
    const int worker_root = 0; // WORKER (worker_comm)

    const int tag = 0;
    char *message = "Hello";

    // 初期化処理
    MPI_Init(&argc, &argv);
    
    // world_size,  universe_size を取得する。
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    if (world_size != 1) {
        // マスタプロセスが複数個存在する場合
        fprintf(stderr, "Error! world_size=%d (expected 1)", world_size);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    MPI_Comm_get_attr(MPI_COMM_WORLD, MPI_UNIVERSE_SIZE, &universe_size_p, &flag);
    if (flag == 0) {
        // universe_size の取得に失敗した場合
        fprintf(stderr, "Error! cannot get universe_size");
        MPI_Abort(MPI_COMM_WORLD, 1);
    }
    universe_size = *universe_size_p;
    printf("universe_size=%d\n", universe_size);
    if (universe_size == 1) {
        // universe_size が 1 の場合
        fprintf(stderr, "Error! universe_size=%d (expected > 1)", universe_size);
        MPI_Abort(MPI_COMM_WORLD, 1);
    }

    // ワーカプロセスとの通信用ポートをオープンする。
    MPI_Open_port(MPI_INFO_NULL, master_port);
    printf("master_port=%s\n", master_port);

    // ワーカプロセスを生成する。
    MPI_Comm_spawn("./worker_spawn.out", MPI_ARGV_NULL, universe_size - 1,
            MPI_INFO_NULL, self_root, MPI_COMM_SELF, &worker_comm, MPI_ERRCODES_IGNORE);

    // ワーカプロセスへポート名を送信する。
    MPI_Send(master_port, MPI_MAX_PORT_NAME, MPI_CHAR, worker_root, tag, worker_comm);

    // ワーカプロセスとの接続を切断する。
    FJMPI_Mswk_disconnect(&worker_comm);

    // ワーカプロセスからのデータを受信する。(ワーカプロセスのポート名が送信されてくる)
    FJMPI_Mswk_accept(master_port, MPI_INFO_NULL, self_root, MPI_COMM_SELF, &worker_comm);
    MPI_Recv(worker_port, MPI_MAX_PORT_NAME, MPI_CHAR, worker_root, tag, worker_comm, &status);
    printf("worker_port=%s\n", worker_port);
    FJMPI_Mswk_disconnect(&worker_comm);

    // ワーカプロセスへデータを送信する。
    FJMPI_Mswk_connect(worker_port, MPI_INFO_NULL, self_root, MPI_COMM_SELF, &worker_comm);
    MPI_Send(message, strlen(message) + 1, MPI_CHAR, worker_root, tag, worker_comm);
    FJMPI_Mswk_disconnect(&worker_comm);

    // 終了処理
    MPI_Close_port(master_port);
    MPI_Finalize();
}
